# Dockerコマンド
---

### イメージの基本操作
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
docker image inspect [イメージ名]
```
- イメージの詳細情報を表示するコマンド
---

### コンテナの基本操作

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
docker container stop [コンテナ名]
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
---
##　新旧Dockerコマンド

|旧コマンド|新コマンド|動作|
|---|---|---|
|docker pull|docker image pull|イメージのダウンロード|
|docker images|docker image ls|イメージ一覧を表示|
|docker rmi|docker image rm|イメージの削除|
|docker ps|docker container ls|コンテナ一覧を表示|
|docker run|docker container run|コンテナの作成と実行|
|docker rm|docker container rm|コンテナの削除|
---
## オプション
|オプション|効果|
|---|---|
|-i|標準入力をOPENにする（デフォルトはCLOSE）|
|-t|出力の表示を整える|
|--rm|コマンドの出力が終了したらこのコンテナを削除する|
|-f|強制的に実行する|
|-d|デタッチドモード|
|-t|任意のTAG名をつける|
|-f|Dockerfileとビルドコンテキストを別々に指定する|

例：
```bash
docker container run -it ubuntu
```
- `-i`を付けないと，ubuntuに対して標準入力ができない
- `-t`を付けないと，出力が最小形式になり見にくい
- このような場合はとりあえず`-it`を付けておく

---


### コンテナ名を任意に設定するコマンド

```bash
docker container run --name -it [任意のコンテナ名] [実行するイメージ]
```
 ---
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

---

### デタッチドモードからの復帰

```bash
docker container attach [コンテナ名]
```
- デタッチドモードになっているコンテナに接続するコマンド

---

### Dockerfileからイメージを作成する

```bash
docker image build [ディレクトリパス]
```
- Dockerfileからイメージを作成する

---

## Dockerfileについて

### 土台の作成

```bash
FROM [土台となるもの]
```

例）ubuntu:latestを土台とする場合
```bash
FROM ubuntu:latest
```
- `latest`はあってもなくても良い
- 
---

### REPOSITORY,TAGの付け方

```bash
docker image build -t [REPOSITORY]:[TAG]
```

---

### Dockerfile内で任意のコマンドを実行させる方法

```bash
FROM ubuntu

RUN apt update
```
- このコードはubuntuを土台として，`apt update`を実行した状態のイメージを作成するという意味

---

### ファイルなどをコピーする方法

```bash
COPY [コピーしたいファイル，ディレクトリのパス] [コピー先のパス]
```
- コピーのためローカルで変更を加えてもコンテナ内のファイルに変更は反映されない

---

### .dockerignoreを利用する

```bash
ueno.txt
large.txt
```
- ビルドコンテキストに含めたくないファイル名を列挙する

---

### デフォルトコマンドを指定する

```bash
CMD ["デフォルトコマンド", "パラメータ1","パラメータ2"]
```
- デフォルトコマンドのため，各Dockerfileにつき1つのみ記載可能
- 複数`CMD`記載があった場合，最後に記載されているもののみ有効
- 記載しなくてもあらかじめデフォルトコマンドが用意されている(例：ubuntuならbash)　　

---

### イメージのレイヤー構造を確認する

```bash
docker image history [イメージ名]
```
---

### レイヤーを分けるメリット・デメリット

|レイヤー|メリット|デメリット|
|---|---|---|
|分ける|レイヤーごとにキャッシュが残るため，変更に強い|イメージ全体の容量が大きくなる|
|分けない|イメージ全体の容量が小さくなる|変更に弱い|

---

### 環境変数

```bash
FROM ubuntu
ENV hello="Hello World"
ENV ueno=UENO
```
- スペースが間に入るときは”`"`必須
- 入らない場合は任意
- `=`の代わりにスペースでも代用可能であるが，公式推奨は`=`である

<br>

#### 環境変数の呼び出し方

```bash
echo $hello
```
- `echo`を用いる
- 環境変数の頭に`$`をつける

---

### 引数設定

```bash
FROM ubuntu
ARG message
RUN echo $message > message.txt
CMD ["cat","message.txt"]
```
- `ARG`は引数であり，値は空でも良い
- `RUN echo $message > message.txt`で引数`message`に与えられた値を出力する

#### 引数に値を与える方法

```bash
docker image build --build-arg message="Hello Message" .
```
- `--build-arg`で変数に値を付与する

---

### ENVとARGの使い分け

|項目|**ENV**|**ARG**|
|--|--|--|
|特性|イメージ作成時とコンテナ実行時，両方で有効な変数|イメージ作成時のみ有効な一時的な変数|
|値の指定|docker run -e または ENV で設定|docker build --build-arg で指定|
|イメージ内への保存|保存される（docker,inspectでも確認可能）|保存されない（実行時には使えない）|

---

### 作業ディレクトリの変更方法

```bash
WORKDIR [ディレクトリパス]
```
- RUNやCMDなどの作業ディレクトリを指定する
- 未指定時は"/"が作業ディレクトリになっている
- 指定したディレクトリが存在しない場合，空のディレクトリを作成してくれる

### OSごとにダウンロードするものをかえる方法

**例**
```txt
pywin32==310 ; sys_platform == "win32"
```
- 









