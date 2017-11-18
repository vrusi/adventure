require '.\engine.rb'


if ARGV[0]
 ARGV[0].chomp == "debug" ? $debug = true : $debug = false
end

def custom_sleep(time)
  if !$debug
    sleep(time)
  end
end

class Scene

  def enter()
  end

end

class Finish < Scene

  def enter()
    puts "Start again? Y/N"
    print "> "
    start_again = $stdin.gets.chomp
    print "\n"

    if start_again == "Y" || start_again =="y" || start_again == "yes" || start_again == "YES"
      puts "Restarting..."
      a_map = Map.new('first_room')
      a_game = Engine.new(a_map)
      a_game.play()
    elsif start_again == "N" || start_again == "n" || start_again == "no" || start_again == "NO"
      puts "Okay. Thanks for playing, hope you enjoyed!"
      custom_sleep(2)
      puts "\n\n\t\t Closing in a few seconds..."
      custom_sleep(5)
    else
      enter
    end
  end
end


class FirstRoom < Scene

  def enter()
    puts "\n\tWelcome! What's your name?"
    print "> "
    $name1 = $stdin.gets.chomp

    puts "\n#{$name1}, you find yourself in a dark room with two doors."
    custom_sleep(1)
    puts "Do you go through door 1 or door 2?"

    print "> "
    door = $stdin.gets.chomp
    print "\n"

    if door == "1"
      return 'room_one'
    elsif door == "2"
      $dagger_obtained = false
      return 'room_two'
    else
      enter
    end
  end
end


class RoomOne < Scene

  def enter()
    puts "There's your partner emerging from the shadow of the room."
    custom_sleep(2)
    puts "What is their name?"
    print "> "
    $name2 = $stdin.gets.chomp
    print "\n"

    puts "\"I've been looking for you,\" #{$name2} says. What do you do?"
    custom_sleep(3)
    puts "\n1. You say: \"Where are we and what are you doing here?\""
    puts "2. You're confused but you're glad to have found #{$name2}. You smile and walk towards #{$name2}."
    print "> "
    partner = $stdin.gets.chomp
    print "\n"

      if partner == "1"
        print "\"I honestly don't know. I've found some stuff while looking around. Take this dagger.\""
        custom_sleep(3)
        puts "You take the dagger and move on. You feel you can move more swiftly."
        $dagger_obtained = true
      elsif partner == "2"
        puts "#{$name2} smiles and hugs you firmly."
        custom_sleep(3)
        puts "\"How did you get here? No, wait. Before we move, look: I've found some stuff while looking around."
        custom_sleep(3)
        puts "Take this dagger.\""
        custom_sleep(2)
        puts "You take the dagger and move on. You feel you can move more swiftly."
        $dagger_obtained = true
      else
        puts "\"I've found this while looking around,\" #{$name2} tells you and hands you a dagger."
        custom_sleep(3)
        puts "You take the dagger and move on. You feel you can move more swiftly."
        $dagger_obtained = true
      end

    custom_sleep(3)
    puts "\"There's nothing where I came from,\" you hear #{$name2} say."
    custom_sleep(3)
    puts "You tell #{$name2} there is one more door in the room you just left. You go there."
    custom_sleep(3)
    puts "You enter door 2."
    custom_sleep(3)
    return 'room_two'
  end
end


class RoomTwo < Scene

  def enter()
    puts "Oh no, there's an axe-wielding skeleton! It's running right towards you! What do you do?\n"
    custom_sleep(3)

    if $dagger_obtained
      puts "\n1. You try to dodge its attack by jumping left."
      puts "2. You try to dodge its attack by jumping right."
      puts "3. You hold on to your dagger tightly and counterattack."
    else
      puts "\n1. You try to dodge its attack by jumping left."
      puts "2. You try to dodge its attack by jumping right."
    end

    print "> "
    skeleton = $stdin.gets.chomp
    print "\n"

    if skeleton == "1"
      puts "Your leap ends on a weirdly looking plane, when you notice there are spikes rising from the ground and stabbing you."
      custom_sleep(3)
      puts "You're dead."
      custom_sleep(2)
      return 'finish'
    elsif skeleton == "2"
      puts "Your leap ends on a suspiciously looking plane, which descends under your weight."
      custom_sleep(3)
      puts "Water pipes are triggered, flooding the room."
      custom_sleep(3)
      puts "The skeleton's bones fall apart under the water pressure."
      custom_sleep(3)
      puts "When the room is flooded, you drown before you can find an exit."
      custom_sleep(3)
      puts "You're dead."
      custom_sleep(2)
      return 'finish'
    elsif skeleton == "3" && $dagger_obtained
      puts "Thanks to the swiftness you gained from wielding the dagger #{$name2} gave you,"
      custom_sleep(3)
      puts "you are able to dodge the skeleton's attack, move behind it and strike its spine."
      custom_sleep(3)
      puts "\nThe skeleton dies."
      custom_sleep(3)
      puts "\"Wow! That was amazing, #{$name1}!\" #{$name2} cheers excitedly,"
      custom_sleep(3)
      puts "\"Look, there's another door. I think there is light coming from behind it.\""
      custom_sleep(3)
      return 'ring'
    else
      return 'room_two'
    end
  end
end


class Ring < Scene
  def enter
    if $ring_first_time
      puts "\nYou notice a ring on one of the skeleton's fingers, with a faintly glowing green light around it. What do you do?"
      custom_sleep(4)
      puts "\n1. You take the ring and put it on."
      puts "2. You leave without the ring, hoping you won't need it."
    elsif !$ring_first_time
      puts "\nYou look at the skeleton's boney hand again. Do you take the ring?"
      custom_sleep(4)
      puts "\n1. You take the ring and put it on."
      puts "2. You leave without the ring, hoping you won't need it."
    end

    print "> "
    ring_choice = $stdin.gets.chomp
    print "\n"

    if ring_choice == "1" && $ring_first_time
      puts "You feel a strange tingling sensation in your chest, but nothing happens."
      custom_sleep(3)
      puts "You're still looking at the skeleton, while #{$name2} opens the door and steps through it."
      custom_sleep(3)
      puts "A ray of light floods the room from outside the door and you can hear #{$name2} shout: \"We're out!\""
      custom_sleep(3)
      puts "You look up at #{$name2} but something about #{$name2}'s silhouette feels wrong."
      custom_sleep(3)
      puts "As you move through the door, you notice #{$name2}'s flesh is decaying."
      custom_sleep(3)
      puts "You look at your hands to realise the same is happening to you while the ring is glowing strongly."
      custom_sleep(3)
      puts "Congratulations! You left the dungeon, but thanks to the cursed ring, you're both dead."
      custom_sleep(3)
      return 'finish'
    elsif ring_choice == "1" && !$ring_first_time
      puts "You feel a strange tingling sensation in your chest, but nothing happens."
      custom_sleep(3)
      puts "You're still looking at the skeleton, while #{$name2} steps through the door and stands in the light."
      custom_sleep(3)
      puts "You look up at #{$name2} but something about #{$name2}'s silhouette feels wrong."
      custom_sleep(3)
      puts "As you move through the door, you notice #{$name2}'s flesh is decaying."
      custom_sleep(3)
      puts "You look at your hands to realise the same is happening to you while the ring is glowing strongly."
      custom_sleep(3)
      puts "Congratulations! You left the dungeon, but thanks to the cursed ring, you're both dead."
      custom_sleep(3)
      return 'finish'
    elsif ring_choice == "2" && !$ring_first_time
      puts "You reach for the ring but before you touch it, something feels wrong."
      custom_sleep(3)
      puts "You decide to leave the ring behind after all."
      custom_sleep(3)
      puts "Stepping outside of the room, you inhale the fresh air."
      custom_sleep(3)
      puts "Congratulations! You left the dungeon alive."
      custom_sleep(3)
      return 'ring_second'
    elsif ring_choice == "2" && $ring_first_time
      puts "You feel a little bit worried and you leave the ring untouched."
      custom_sleep(3)
      puts "You open the door and blinded by the strong light, you realise this is the exit."
      custom_sleep(3)
      puts "Congratulations! You left the dungeon alive."
      custom_sleep(3)
      puts "You're still wondering what could have happend if you had taken the ring."
      return 'ring_second'
    else
      return 'ring'
    end
  end
end


class RingSecond < Scene
  def enter
    puts "Do you want to return for the ring? Y/N"
    print "> "
    rring = $stdin.gets.chomp
    print "\n"

    if rring == "Y" || rring == "y"
      $ring_first_time = false
      return 'ring'
    elsif rring == "N" || rring == "n"
      puts "Assured that you're fine without the ring, you move on and head home. Congratulations!"
      custom_sleep(3)
      return 'finish'
    else
      return 'ring_second'
    end
  end
end


class Map

@@scenes = {
  'first_room' => FirstRoom.new(),
  'room_one' => RoomOne.new(),
  'room_two' => RoomTwo.new(),
  'ring' => Ring.new(),
  'ring_second' => RingSecond.new(),
  'finish' => Finish.new(),
}

  def initialize(start_scene)
    @start_scene = start_scene
  end

  def next_scene(scene_name)
    val = @@scenes[scene_name]
    return val
  end

  def opening_scene()
    return next_scene(@start_scene)
  end
end


a_map = Map.new('first_room')
a_game = Engine.new(a_map)
a_game.play()
