
# テナントごとにサブドメインを分ける.
# ユーザログイン / sign up は app.* ドメインでおこなう.
# -> クッキーをサブドメイン間で共有する。

# See https://techracho.bpsinc.jp/baba/2012_11_19/6393

# またこの場合, `localhost` は使えないかも?
# See https://qiita.com/ishiitakeru/items/70caadc8a4dec7611a5d

# @note 第2引数以降は Hash ではない
Rails.application.config.session_store :cookie_store, 
                    key: '_mysession',
                    domain: :all,
                    tld_length: ActionDispatch::Http::URL.tld_length + 1


