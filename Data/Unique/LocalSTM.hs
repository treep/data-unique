
module Data.Unique.LocalSTM
  ( UniqueT
  , evalUniqueT
  , getUnique
  ) where

import Data.Word
import Control.Concurrent.STM
import Control.Monad.State.Strict

import Data.Unique.Internal

type UniqueT = StateT (TVar Word) IO

evalUniqueT :: UniqueT a -> IO a
evalUniqueT st = atomically (newTVar 0) >>= (st `evalStateT`)
{-# INLINE evalUniqueT #-}

getUnique :: a -> UniqueT (Unique a)
getUnique x = do
  local <- get
  i <- liftIO $ atomically $ do
    i <- readTVar local
    writeTVar local $ i + 1
    return i
  -- no put!
  return $! MkUnique i x
{-# INLINE getUnique #-}
