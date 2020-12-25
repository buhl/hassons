
shell-radicale:
	cd test/radicale && \
	docker run --rm -it --entrypoint /bin/bash \
		-v $$PWD/addons:/addons \
		-v $$PWD/data:/data \
		-p 5232:5232 \
		buhl/ha-addon-amd64-radicale

run-radicale:
	cd test/radicale && \
	docker run --rm -it \
		-v /home/user/repos/hassons/addons:/addons/ \
		-v /home/user/repos/hassons/data:/data/ \
		-p 5232:5232 \
		buhl/ha-addon-amd64-radicale

build-radicale:
	docker run --rm --privileged \
		-v ~/.docker:/root/.docker \
		-v /var/run/docker.sock:/var/run/docker.sock:ro \
		-v $$PWD/radicale:/data \
		homeassistant/amd64-builder \
		--all --target /data --test

push-radicale:
	docker run --rm --privileged \
		-v ~/.docker:/root/.docker \
		-v /var/run/docker.sock:/var/run/docker.sock:ro \
		-v $$PWD/radicale:/data \
		homeassistant/amd64-builder \
		--all --target /data --docker-hub-check


build-help:
	@docker run --rm homeassistant/amd64-builder --help
