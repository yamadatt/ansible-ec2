EC2でラジオのリアルタイム録音をするためのansible

このansibleで毎日17:55から約3時間TBSラジオを録音するようになる。

## 事前準備

事前に以下を実施しておくこと。

### ターゲットノード構築

初期設定対象のサーバ（ターゲットのーど）はEC2で作成し、sshでログインできる状態にしておく。

### 事前設定

以下を書き換える。


[hosts](./hosts)

```
[targethost]
3.113.9.172　←　構築時に払い出されたIPアドレスに変更する

[targethost:vars]
ansible_ssh_port=22
ansible_ssh_user=ec2-user
ansible_ssh_private_key_file=/ansible/radio.pem　←　必要に応じて書き換える
ansible_become=yes
host_key_checking=False
```



## 環境

ansible用のコンテナーにアタッチして、コンテ上でansibleコマンドを使用する。

### ansibleの準備

可能な限りボータビリティを持たせ、再現性を高めるため、dockerによりansiblを起動するようにしている。

dockerイメージのbuild。

    sudo docker build . -t ansible

### コンテナーにアタッチ

カレントディレクトリをマウントしてコンテナーを起動する。と、同時にコンテナーにアタッチする。

    docker run --rm -it -v $(pwd):/ansible ansible bash

### コマンド

コンテナーにアタッチした状態で以下のコマンドで動く。

  ansible-playbook -i hosts site.yml

### 構文チェック（テスト）

PlaybookがYAMLとして正しく解釈できるか、存在しないモジュールを使用していないかは、以下のように```--syntax-check```をつけて実行する。

```bash
ansible-playbook -i hosts site.yml --syntax-check
```
