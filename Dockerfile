FROM ubuntu:20.04

RUN apt update
RUN apt install -y curl

COPY ./hello.txt /app/

CMD ["bash"]
