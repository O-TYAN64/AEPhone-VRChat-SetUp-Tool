# AEPhone-VRChat-SetUp-tool 

# システム初期化中に、エラーコードも出ずにAEphone_HUBが最初の画面に戻ってる場合の対処法
## VRChat_OSC_Firewall_Patch
AEPhone_HUBのAEphone_android起動時にvrchatのoscポート許可の確認もしくは、9000もしくは9001のポート開放の確認を初回時に行ってる可能性があり、このパッチを使ってえばAEPhoneが使える可能性があります<br>
(AEPhoneのソースコードを見ていないので経験と知識での作成です)<br>
### 管理者権限必要なので、右クリックで管理者で起動を押してね
## 手順:
**1.vrchat_osc_firewall_patch.batをダウンロードし管理者権限で起動する、成功したらパソコンを再起動<br>
(ファイヤーウォール許可やポート開放していれば、2から始めてもよい)<br>
2.AEPhone HUB起動<br>
3.スマホのみをPCに接続し、AEPhone HUBのandroidで起動を押す<br>
4.ステータスがAEPhone_android 起動完了 になったら、HMDを接続し、VRChatを起動する<br>
5.AEPhone HUBの終了ボタンを押し、再度androidで起動を押す**<br>
※手順1ができていれば2番以降は飛ばしても大丈夫です、人によってはこの手順でうまくいかない場合もあります、ご承知お願いします<br>
※これでうまくいかない場合、aephone_hubのソースコードを見ないと原因究明ができない場合がありますので、ご承知お願いします<br>
これでもうまくいかない場合は、AEPhone公式[discord](https://discord.gg/YQcaQVyf8E)まで
# USBケーブルが使えれるか確認したい
## USBケーブルチェッカー
adbコマンドを使った接続ができるかの確認できるbatファイルまたは、exeファイルを作りました<br>
**AEPhoneのダウンロード場所に置いてもらって起動すると、そのケーブルが使えるか確認できます。<br>
USBデバックは必ずONにしてください**<br>
初期状態では下記のパスにインストールされます。<br>
``C:\Users\ユーザーネーム\AppData\Local\AEPhone``<br>
