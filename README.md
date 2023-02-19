EC2でラジオのリアルタイム録音をするためのansible

このansibleで毎日17:55から約3時間TBSラジオを録音するようになる。

## 事前準備

事前に以下を実施しておくこと。

### ターゲットノード構築

初期設定対象のサーバ（ターゲットのーど）はEC2で作成し、sshでログインできる状態にしておく。

## IPアドレスの書き換え

対象ホストのIPアドレス書き換える。

EC2はIPアドレスがその都度変わるため、ターゲットサーバのIPアドレスを書き換える

## 鍵のファイルパス書き換え

鍵ペアのファイルを以下で設定した場所に格納する。

下の例だと、```/etc/ansible/pemfile/radio.pem```

```
ansible_ssh_private_key_file=/etc/ansible/pemfile/radio.pem
```

## playbook概要

以下のようなことを実施する。

* パッケージの最新化
* git、dockerのインストール
* タイムゾーンの変更
* dockerファイルのダウンドーロ
* docker build
* cron設定

## 環境

動作確認をした環境は以下。


OS：CentOS 7.4

ansibleバージョン

```
$ ansible --version
ansible 2.10.9
  config file = None
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python3.6/site-packages/ansible
  executable location = /usr/local/bin/ansible
  python version = 3.6.8 (default, Aug 24 2020, 17:57:11) [GCC 8.3.1 20191121 (Red Hat 8.3.1-5)]
```

## 使い方

### コマンド

以下のコマンドで動く。

  ansible-playbook -i hosts site.yml

### 構文チェック（テスト）

PlaybookがYAMLとして正しく解釈できるか、存在しないモジュールを使用していないかは、以下のように```--syntax-check```をつけて実行する。

  ansible-playbook -i hosts site.yml --syntax-check