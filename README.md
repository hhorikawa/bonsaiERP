
[![License](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/hhorikawa/bonsaiERP/blob/main/MIT-LICENSE.md)



# *bonsaiERP*

*bonsaiERP* is a simple ERP multitenant system written with [Ruby on Rails](http://rubyonrails.org) and includes the following modules:

- Sales
- Buys
- Expenses
- Bank and Cash Accounts
- Inventory
- Multi currency
- Multiple companies
- File management (in development)

The system allows to use multiple currencies and make exchange rates.



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
