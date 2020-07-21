



class VendingMachine
  attr_reader :slot_money, :sales, :drink
  # ステップ０　お金の投入と払い戻しの例コード
  # ステップ１　扱えないお金の例コード
  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  MONEY = [10, 50, 100, 500, 1000].freeze
  # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
  #ドリンクを格納する
  def initialize
    # 最初の自動販売機に入っている金額は0円
    @slot_money = 0
    #売り上げを定義
    @sales = 0
    #ドリンクを格納する
    @drink = []
  end

  def add_drink(name,price,stock)
    names = []
    @drink.map{|drink| names << drink[:name]}
    names.include?(name) ?  @drink.map{|drink| drink[:stock] += stock if name == drink[:name] } : @drink << {name: "#{name}", price: price, stock: stock}
  end

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def add_money(money)
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    return false unless MONEY.include?(money)
    # 自動販売機にお金を入れる
    @slot_money += money
    puts @slot_money
    available_drinks(@drink)
    @drink.map{|drink| drink_information(drink[:name]) }
  end

  #手持ちのお金でドリンクが買えるか表示
  def available_drinks(drinks)
    #各ドリンクが買えるか判断
    @drink.map{|drink| puts "#{drink[:name]}買えます" if ( drink[:price] <= @slot_money ) && ( drink[:stock] > 0 )}
  end

  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  def return_money
    # 返すお金の金額を表示する
    puts "お釣り：#{@slot_money}円"
    # 自動販売機に入っているお金を0円に戻す
    @slot_money = 0
  end


  def drink_information(name)
    @drink.each do |drink|
      if name == drink[:name]
        puts "名前：#{drink[:name]} 値段：#{drink[:price]} 在庫：#{drink[:stock]}"
        if drink[:stock] <= 0
          puts "#{drink[:name]}は売り切れです"
        elsif @slot_money < drink[:price]
          puts "お金が足りません"
        end
      end
    end
  end


  def buy_drink(name)
    @drink.each do |drink|
      if ( name == drink[:name] ) && ( drink[:stock] > 0 ) && ( @slot_money >= drink[:price] )
        puts "#{drink[:name]}１本"
        #ストックを１本減らす
        drink[:stock] -= 1
        #手持ち金額から減らす
        @slot_money -= drink[:price]
        #売り上げをたす
        @sales += drink[:price]
        #お釣りを返す
        return_money
      end
    end
  end
end
