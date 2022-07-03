FROM alpine
RUN apk add --no-cache git ldc clang lld dub \
  musl-dev compiler-rt llvm-libunwind-static ncurses-static

WORKDIR /work/yamad
RUN git clone -b v1 https://github.com/yamader/yama.d . && \
  dub add-local .

WORKDIR /work/termisskey
COPY . .
ARG DFLAGS="--gcc=clang --linker=lld \
  --Xcc=-rtlib=compiler-rt --Xcc=-Wl,-z,nostart-stop-gc"
RUN dub build -c static -b release --parallel
