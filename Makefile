.PHONY: release install test cov build compile lint

release: cov build compile
	rm -rf build
	mkdir build
	cp dist build -r
	cp backend/dist build/server -r
	cp backend/package.json build/package.json
	rm build/server/*.test.js
	printf "npm install --omit=dev && DEBUG=predator:server:token node ./server" >build/run.sh
	printf "npm install --omit=dev && set DEBUG=predator:server:toekn && node .\server" >build/run.bat

install:
	npm install
	cd backend && npm install

test: install
	npm run test

cov: install
	npm run cov

build: install
	npm run build

compile: install
	cd backend && npm run compile

lint: install
	npm run lint

clean:
	rm -rf build dist node_modules
	rm -rf backend/coverage backend/dist backend/node_modules
