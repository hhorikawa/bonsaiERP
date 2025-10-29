
# *bonsaiERP 3*, renovation

[![License](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/hhorikawa/bonsaiERP/blob/main/MIT-LICENSE.md)


<i>bonsaiERP 3</i> is a simple ERP multitenant system written with [Ruby on Rails](https://rubyonrails.org/) and includes the following functions:

入出庫に伴って, どのように記帳するか, 収支ダッシュボードをどのように作るか, が中心.
インボイス機能は持たない

 - Dashboard
   + Profit report
   + Inventory report
   
 - Master Data
   + ✅ Business Partners
     - 取引先口座 OK
     - <s>TODO: edit.</s> fixed.
     - <s>TODO: When a user create a business partner, the system must create the first account at the same time. `:new` screen.</s> fixed.
   + ✅ Product/Item Master
   + ✅ Units of Measure
   + ✅ Store/Warehouse

 - Finance
   + ✅ Cash / Bank Account
   + Loan
   + Payment
   + Currency
   + Tax
   + ✅ Chart of Accounts
   + Tags   --- どんな機能性だろう?
   + ❌ General Ledger
   
 - Sales
   + ✅ Sales Order
   + In-Store Sales w/o order
   + Customer Return
   
 - Purchasing
   + ✅ Purchase Order and Cancel
     - If there is an under-delivery, the system should be able to modify the order and close it, but the system has not been implemented.
   + Purchases in Transit: When an invoice is received *before* the goods have arrived, the invoice is posted in the *Purchases in Transit* account but has no assignment to a goods receipt at this point.
     - TODO: mockup of invoice.
     
 - In-Store/Warehouse Operations
   + ✅ Goods Receipt PO
     - <s>TODO: PO balance 減算</s> fixed.
     - <s>TODO: 仕訳の生成. </s> fixed.
     - 数量が異なる場合の考慮.
   + Goods Return 仕入戻し
   + Delivery
   + Transfer Stock - Out
   + Transfer Stock - In
   + Inventory Count and Adjustment
   + Material Documents 入出庫伝票
   + Stock
 
 - Project
   + Production Order

 - Configuration
   + Organisation     TODO: Have a functional currency
   + User Profile   


## Overall

 - Multi-currency
   The system allows to use multiple currencies and make exchange rates.
   TODO:
     + Historical exchange rates is needed
 - Multiple companies
   It uses the tenant function to completely isolate each company's data.

 - File management (in development)
   ActiveStorage は Rails 5.2 で導入された。




## *bonsaiERP 3*, renovation

<i>bonsaiERP 3</i> は, v2 までと互換性がありません。


### Frontend

 - Chart は <i>Chart.js</i> の v1.x 辺り。古すぎる。差し替える. Use `apexcharts`.
 - AngularJS v1.x 時代 (v1.0.0 = 2012年6月)。これも古すぎる. 作り直すしかない

Rails 8時代のフロントエンド

 - Hotwire (Turbo, Stimulus)  -- takes care of at least 80% of the interactivity
 
 - ▲ API mode + SPA アーキテクチャ (React)  -- 開発効率が悪すぎる
 
 - Inertia.js  -- APIレスのフロントエンド
   + <a href="https://techracho.bpsinc.jp/hachi8833/2025_10_20/153731">Rails: Inertia.jsでRailsのJavaScript開発にシンプルさを取り戻そう（翻訳)</a>
   + <a href="https://kinsta.com/jp/blog/inertia-js/">Inertia.jsの基本的な特徴や仕組み（徹底解説)</a> <blockquote><code>Link</code> がクリックされると、Inertiaがクリックイベントに介入し、XHRリクエストをサーバーに送信。サーバーはこれがInertiaのリクエストであることを認識して、JSONのレスポンスを返します。このレスポンスにはJavaScriptのコンポーネント名とデータが含まれており、その後、Inertiaは不要なコンポーネントを削除し、新しいページの訪問（表示）に必要なコンポーネントに置き換え、履歴の状態を更新</blockquote>

 - "react_on_rails" gem ("react-rails" の後継). コンポーネント単位で表示


TODO: Install a UI library.
 - <a href="https://github.com/ColorlibHQ/gentelella/">ColorlibHQ/gentelella: Free Bootstrap 5 Admin Dashboard Template</a> or
 - <a href="https://flowbite.com/">Flowbite - Build websites even faster with components on top of Tailwind CSS</a>

 - https://coreui.io/bootstrap/docs/forms/stepper/ PRO only
 - <a href="https://daisyui.com/">Tailwind CSS Component Library ⸺ daisyUI</a>



### Models

 - `accounts` table が取引を記録するようになっていたが, 設計がおかしい。v3 では, `accounts` table は勘定科目マスタ, `account_ledgers` table が仕訳を持つようにした。
 - `movement_details` table は `accounts` table にぶら下がっていた。上のとおり, `accounts` table は勘定科目マスタにして, `transactions` table を `orders` として復活させ、そこにぶら下げるようにした。`20140217134723_drop_transactions_table.rb` で drop しているのがおかしい。

●● おそらく, `stocks` table も時系列になっていないのでおかしい。




## Statechart of Inventory

See https://qiita.com/MelonPanUryuu/items/0372582e8b8e4e6ad1b4
    The diagrams are helpful, but there are many gaps.

```
        103?        <02>                105🚩? 321?
     +----------> [inspection stock]  -----------+ 
     |    < 124?                                 |
     |      107🚩   <10>              109        v    <01>         251 or 261
[supplier] -----> [valued blocked]  ------>  [unrestricted stock]  ---> [for sale]
     |      < 108                                ^            |    221
     |     122       <03>              161    |  |  |      |  +-------> [issue for prj]
     |  <--------  [return for PO]  <---------+  |  |      |  
     |                                           |  |      |  
     +-------------------------------------------+  |      |201
                                101🚩 >             |      v
                                                    |   [cost center]
                                                    v 541
                                                [subcontract] 
```
missing: 102, 162, 542

```
          303       <05>      305
[store] --------> [transfer] -------> [store]
```
storage location to location in one step: 311



## Installation

See <a href="INSTALL.md">INSTALL.md</a>


in development you will need to edit but in production you can configure
so you won't need to edit the `/etc/hosts` file for each new subdomain, start the app `rails s` and go to
http://app.localhost.bom:3000/sign_up to create a new account,
to capture the email with the registration code use [mailcatcher](http://mailcatcher.me/). Fill all registration fields
and then check the email that has been sent, open the url changing the port and you can finish creation of a new company.

> The system generates automatically the subdomain for your company name
> with the following function `name.to_s.downcase.gsub(/[^A-Za-z]/, '')[0...15]`
> this is why you should have the subdomain in `/etc/hosts`


### Attached files (UPLOADS)

*bonsaiERP* uses dragonfly gem to manage file uploads, you can set where
the files will go setting:

`config/initialiazers/dragonfly.rb`



# License

By [Boris Barroso](https://github.com/boriscy) under MIT license:

> Copyright (c) 2015 Boris Barroso.
>
> Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to > deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or > sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
