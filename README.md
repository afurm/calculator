# Calculator
Input

- amount *required

- commission_amount *optional

- commission_percent *optinal

- commission_entity(user, product) *optional

Output -

[netto_amount, commission_amount]


3. Якшо нема комісії - то вона встановлюється фіксованою.

4. Можливість змінювати комісію в залежності від:

- типу продукту

- користувача

- ціни продукту(amount)

5. Код покрити юніт тестами.

6. Можливість рахувавти комісію з точністю до двох знаків після коми


Calculator.call(amount: 100, commission_amount: 1.0, commission_percent: 20)

commission_total = 100.0 * 0.2 + 1.0 = 21.0

net_amount = 100.0 - 21.0 = 79.0

=> [79.0, 21.0]

Add this line to your application's Gemfile:

```ruby
gem 'calculator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install calculator
