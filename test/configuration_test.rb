require 'util'
require 'hella'

class ConfigurationTest < Test::Unit::TestCase

  def setup
    @base = Hella::Base.new :dotfile => '/home/brennandunn/.hellarc'
  end
  
  def test_for_hellarc_file
    @base.expects(:load_rc)
    @base.connect
  end
  
  def test_for_creation_of_hellarc_file
    begin
      @base.configuration[:dotfile] = File.expand_path('~/.fakehellarc')
      @base.write_rc
      assert File.exists?(@base.configuration[:dotfile])
    ensure
      # remove .fakehellarc
      File.delete(@base.configuration[:dotfile])
    end
  end
  
  def test_applying_hellarc_file_to_connection
    @base.stubs(:load_rc).returns({
      :host => 'otherhost'
    })
    
    @base.connect
    assert_equal 'otherhost', @base.connection.host
  end
  
end