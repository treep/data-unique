{-# LANGUAGE ScopedTypeVariables, Rank2Types #-}

import Data.Word
import Control.Monad.State.Strict

import Data.Unique
import qualified Data.Unique.Local as L
import qualified Data.Unique.Global as G
import qualified Data.Unique.LocalSTM as LSTM
import qualified Data.Unique.GlobalSTM as GSTM

test :: MonadIO m => (forall a. a -> m (Unique a)) -> m ()
test genf = do
  w :: Word <- liftIO $ read `fmap` getLine
  i :: Int <- liftIO $ read `fmap` getLine
  a <- genf w
  b <- genf i
  liftIO $ print (_id a, _id b)

local, global, localSTM, globalSTM :: IO ()

local = L.evalUniqueT $ test L.getUnique

global = test G.getUnique

localSTM = LSTM.evalUniqueT $ test LSTM.getUnique

globalSTM = test GSTM.getUnique
