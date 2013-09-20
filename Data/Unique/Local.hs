
module Data.Unique.Local
  ( UniqueT
  , evalUniqueT
  , getUnique
  ) where

import Data.Word
import Control.Monad.State.Strict

import Data.Unique.Internal

type UniqueT = StateT Word

evalUniqueT :: Monad m => UniqueT m a -> m a
evalUniqueT = (`evalStateT` 0)
{-# INLINE evalUniqueT #-}

getUnique :: Monad m => a -> UniqueT m (Unique a)
getUnique x = do
  i <- get
  put $ i + 1
  return $! MkUnique i x
{-# INLINE getUnique #-}
