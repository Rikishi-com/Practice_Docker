# Dockerコマンド
---
```bash
docker image pull [イメージ名]
```
- イメージをダウンロードするコマンド

```bash
docker image ls
```
- ローカルマシンに存在するイメージ一覧を表示するコマンド

```bash
docker image rm [イメージ名]
```
- ローカルマシンに存在するイメージを削除するコマンド

```bash
docker container run [イメージ名]
```
- イメージからコンテナを作成し，起動するコマンド

```bash
docker container ls
```
- ローカルマシンに存在するコンテナ一覧を表示するコマンド
- `-e`オプションをつけることで，起動していないコンテナも表示される

```bash
docder container stop [コンテナ名]
```
- 起動中のコンテナを止めるコマンド

```bash
docker container restart [コンテナ名]
```
- コンテナを再起動する（upにする）コマンド


