class Condition < ActiveHash::Base
  self.data = [
    {id: 1, name: '新品、未使用'},{id: 2, name: '未使用に近い'},{id: 3, name: '目立った傷や汚れなし'},{id: 4, name: 'やや傷や汚れあり'},{id: 5, name: '傷や汚れあり'},{id: 6, name: '全体的に状態が悪い'}
  ]
end
class Delivery_cost < ActiveHash::Base
  self.data = [
    {id: 1, name: '送料込み（出品者負担）'},{id: 2, name: '着払い（購入者負担）'}
  ]
end