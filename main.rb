require 'io/console'

class Janken
  def initialize
    @results = {}
    @results.default = 0
  end

  def start
    puts "何本勝負？(press 1 or 3 or 5)"
    @number = STDIN.noecho(&:gets).chomp
    if @number.match(/[135]/) 
      puts "#{@number}本勝負を選びました"
    else 
      start
      return
    end
    main
  end

  def main
    @number.to_i.times do |i|  
      puts "\n"
      puts "#{i+1}本目"
      # puts "じゃんけん...(press g or c or p)"
      # player = STDIN.noecho(&:gets).chomp 
      player = ''
      until player.match(/[cgp]/)
        puts "じゃんけん...(press g or c or p)"
        player = STDIN.noecho(&:gets).chomp 
      end
      play(player)
    end
    show_result
  end

  def play(player)
    cpu = ['g', 'c', 'p'].sample
    janken = {'g' => 'グー', 'p' => 'パー', 'c' => 'チョキ'}
    puts "CPU...#{janken[cpu]}"
    puts "あなた...#{janken[player]}"
    judge(cpu, player)
  end

  def judge(cpu, player)
    if cpu == player
      player = ''
      until player.match(/[cgp]/)
        puts "あいこで...(press g or c or p)"
        player = STDIN.noecho(&:gets).chomp 
      end
      play(player)
      return 
    elsif cpu == 'p' && player == 'g' || cpu == 'g' && player == 'c' || cpu == 'c' && player == 'p'
      @results[:lose] += 1
      puts '負け！'
    else
      @results[:win] += 1
      puts '勝ち！'
    end
    puts "#{@results[:win]}勝#{@results[:lose]}敗"
  end
  
  def show_result
    if @results[:lose] < @results[:win]
      result = "勝ち"
    else
      result = "負け"
    end
    puts "\n"
    puts '結果' 
    puts "#{@results[:win]}勝#{@results[:lose]}敗であなたの#{result}"
  end
end

janken = Janken.new
janken.start
