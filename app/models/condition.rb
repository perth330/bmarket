class Condition < ActiveHash::Base
  self.data = [
    {id: 1, name: '選択してください'},{id: 2, name: '新品、未使用'},{id: 3, name: '未使用に近い'},{id: 4, name: '目立った傷や汚れなし'},{id: 5, name: 'やや傷や汚れあり'},{id: 6, name: '傷や汚れあり'},{id: 7, name: '全体的に状態が悪い'}
  ]
end
class Delivery_cost < ActiveHash::Base
  self.data = [
    {id: 1, name: '選択してください'},{id: 2, name: '送料込み（出品者負担）'},{id: 3, name: '着払い（購入者負担）'}
  ]
end