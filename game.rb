class Game

  attr_accessor :status, :errors, :letters, :good_letters, :bad_letters
  def initialize(slovo)
    @letters = get_letters(slovo)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = 0
  end

  def get_letters(slovo)
    if slovo == nil || slovo == ""
      abort "Загадано пустое слово, нечего отгадывать. Закрываемся"
    end
    return slovo.split("")
  end

  def next_step(bukva)
    return if @status == -1 || @status == 1
    return if @good_letters.include?(bukva) || @bad_letters.include?(bukva)

    if letters.include?(bukva) ||
       (bukva == "е" && letters.include?("ё")) ||
       (bukva == "ё" && letters.include?("е")) ||
       (bukva == "и" && letters.include?("й")) ||
       (bukva == "й" && letters.include?("и"))
    end

    good_letters << "ё" if bukva == "е"
    good_letters << "е" if bukva == "ё"
    good_letters << "й" if bukva == "и"
    good_letters << "и" if bukva == "й"

    if @letters.include?(bukva)
      @good_letters << bukva
      if @good_letters.uniq.sort == @letters.uniq.sort
        @status = 1
      end
    else
      @bad_letters << bukva
      @errors += 1
      if @errors >= 7
        @status = -1
      end
    end
  end

  def ask_next_letter
    puts "\nВведите следующую букву"
    letter = ""
    letter = UnicodeUtils.downcase(STDIN.gets.strip, :tr) while letter == ""
    next_step(letter)
  end
end
