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

```bash
docker container rm [コンテナ名]
```
- コンテナを破棄するコマンド

##　新旧Dockerコマンド

|旧コマンド|新コマンド|動作|
|---|---|---|
|docker pull|docker image pull|イメージのダウンロード|
|docker images|docker image ls|イメージ一覧を表示|
|docker rmi|docker image rm|イメージの削除|
|docker ps|docker container ls|コンテナ一覧を表示|
|docker run|docker container run|コンテナの作成と実行|
|docker rm|docker container rm|コンテナの削除|

## オプション
|オプション|効果|
|---|---|
|-i|標準入力をOPENにする（デフォルトはCLOSE）|
|-t|出力の表示を整える|
|--rm|コマンドの出力が終了したらこのコンテナを削除する|
|-f|強制的に実行する|

例：
```bash
docker container run -it ubuntu
```
- `-i`を付けないと，ubuntuに対して標準入力ができない
- `-t`を付けないと，出力が最小形式になり見にくい
- このような場合はとりあえず`-it`を付けておく

---

```bash
docker image inspect [イメージ名]
```
- イメージの詳細情報を表示するコマンド

```bash
docker container run [イメージ名] [実行したいコマンド]
```
- コンテナを起動して任意のコマンドを自校させるコマンド
- イメージからコンテナを新規作成し，コマンドを実行する

```bash
docker container exec [コンテナ名] [実行したいコマンド]
```
- Up状態のコンテナに任意のコマンドを実行させるコマンド
- 既存のコンテナで，コマンドを実行する
- `bash`を実行したいコマンドにいれることで，再度通常のLinuxのような操作が可能

```bash
docker container exec -it [コンテナ名] bash
```

### コンテナ名を任意に設定するコマンド

```bash
docker container run --name -it [任意のコンテナ名] [実行するイメージ]
```
 
### コンテナを整理するコマンド

```bash
docker container prune
```
- 既にstopしているコンテナをすべて削除する

```bash
docker container run --rm [イメージ名]
```
- `--rm`オプションをつけると，コンテナ実行した後自動削除する

```bash
docker container rm -f [コンテナ名]
```
- `-f`オプションをつけると，停止中や実行中関係なく矯正削除できる