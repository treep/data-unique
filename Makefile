
all:
	runhaskell Setup configure --user
	runhaskell Setup build

install: all
	runhaskell Setup install

doc: all
	cabal haddock
	mv ./dist/doc/html/data-unique ./doc

tar:
	cabal sdist

lint:
	hlint .

clean:
	rm -rf dist doc
