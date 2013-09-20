
module Data.Unique.GlobalSTM
  ( getUnique
  ) where

import Data.Word
import Control.Concurrent.STM
import System.IO.Unsafe

import Data.Unique.Internal

global :: TVar Word
global = unsafePerformIO $ newTVarIO 0
{-# NOINLINE global #-}

getUnique :: a -> IO (Unique a)
getUnique x = atomically $ do
  i <- readTVar global
  writeTVar global $ i + 1
  return $! MkUnique i x
{-# INLINE getUnique #-}
