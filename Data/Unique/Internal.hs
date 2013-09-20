
module Data.Unique.Internal
  ( Unique ( MkUnique )
  , _id
  , _object
  ) where

import Data.Word

data Unique a = MkUnique { _id :: {-# UNPACK #-} !Word, _object :: a }

-- | Weak equality.
instance Eq (Unique a) where
  x == y = _id x == _id y
  {-# INLINE (==) #-}

-- | Weak ordering.
instance Ord (Unique a) where
  x < y = _id x < _id y
  {-# INLINE (<) #-}
