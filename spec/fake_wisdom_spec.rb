require File.expand_path('../../lib/fake_wisdom', __FILE__)

RSpec.describe FakeWisdom do

  context "general" do

    it "has a version number" do
      expect(FakeWisdom::VERSION).not_to be nil
    end
      
  end


  context "option" do

    it "default value is:" do
      f = FakeWisdom.new
      expect(f.maxlength).to eq(80)
      expect(f.multiline).to eq(false)
    end

    it "can set:" do
      f = FakeWisdom.new maxlength: 40, multiline: true
      expect(f.maxlength).to eq(40)
      expect(f.multiline).to eq(true)
      #TODO: option :file canset dictionary file
    end

    it "fuzzy type:" do
      f = FakeWisdom.new maxlength: "15", multiline: nil
      expect(f.maxlength).to eq(15)
      expect(f.multiline).to eq(false)
    end

  end


  context "get" do

    it "get without length returns 1 text" do
      f = FakeWisdom.new
      strings = f.get
      expect(strings.class).to eq(Array)
      expect(strings.length).to eq(1)
    end

    it "return value check" do

      [true, false].each{|multiline|
        puts "multiline is: #{multiline}"

        [10, 15, 45, 111].each{|maxlength|
          puts "maxlength is: #{maxlength}"
          f = FakeWisdom.new({
            :maxlength => maxlength,
            :multiline => multiline,
          })

          [10, 100, 400].each{|count|
            puts "count is: #{count}"
            strings = f.get count
            expect(strings.length).to eq(count)      
            strings.each{|string|
              expect(string.length).to be <= maxlength
            }
          }
        }
      }
    end

  end

end
