
module Data.Unique.Global
  ( getUnique
  ) where

import Data.Word
import Data.IORef
import System.IO.Unsafe

import Data.Unique.Internal

global :: IORef Word
global = unsafePerformIO $ newIORef 0
{-# NOINLINE global #-}

getUnique :: a -> IO (Unique a)
getUnique x = do
  i <- readIORef global
  writeIORef global $ i + 1
  return $! MkUnique i x
{-# INLINE getUnique #-}
