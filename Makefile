
build:
	docker build -t my-net-tools .
	docker tag my-net-tools luckymode/my-net-tools

run:
	docker run --rm -it luckymode/my-net-tools
