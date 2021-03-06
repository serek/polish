require File.dirname(__FILE__) + '/../../spec_helper'
 
describe I18n, "Polish Date/Time localization" do
  before(:all) do
    @date = Date.parse("1985-12-01")
    @time = Time.local(1985, 12, 01, 16, 05)
  end
  
  describe "with date formats" do
    it "should use default format" do
      l(@date).should == "01.12.1985"
    end
 
    it "should use short format" do
      l(@date, :format => :short).should == "01. gru."
    end
 
    it "should use long format" do
      l(@date, :format => :long).should == "01. grudnia 1985"
    end
  end
  
  describe "with date day names" do
    it "should use day names" do
      l(@date, :format => "%d %B (%A)").should == "01 grudnia (niedziela)"
      l(@date, :format => "%d %B %Y roku była %A").should == "01 grudnia 1985 roku była niedziela"
    end
 
    it "should use standalone day names" do
      l(@date, :format => "%A").should == "Niedziela"
      l(@date, :format => "%A, %d %B").should == "Niedziela, 01 grudnia"
    end
    
    it "should use abbreviated day names" do
      l(@date, :format => "%a").should == "Nie."
      l(@date, :format => "%a, %d %b %Y").should == "Nie., 01 gru. 1985"
    end
  end
  
  describe "with month names" do
    it "should use month names" do
      l(@date, :format => "%d %B").should == "01 grudnia"
      l(@date, :format => "%e %B %Y").should == " 1 grudnia 1985"
    end
    
    it "should use standalone month names" do
      l(@date, :format => "%B").should == "Grudzień"
      l(@date, :format => "%B %Y").should == "Grudzień 1985"
    end
    
    it "should use abbreviated month names" do
      @date = Date.parse("1985-03-01")
      l(@date, :format => "%d %b").should == "01 mar."
      l(@date, :format => "%e %b %Y").should == " 1 mar. 1985"
    end
    
    it "should use standalone abbreviated month names" do
      @date = Date.parse("1985-03-01")
      l(@date, :format => "%b").should == "Mar."
      l(@date, :format => "%b %Y").should == "Mar. 1985"
    end
  end
 
  it "should define default date components order: year, month, day" do
    I18n.backend.translate(Polish.locale, :"date.order").should == [:year, :month, :day]
  end
 
  describe "with time formats" do
    it "should use default format" do
      l(@time).should =~ /^Nie., 01. grudnia 1985, 16:05:00/
    end
 
    it "should use short format" do
      l(@time, :format => :short).should == "01. gru., 16:05"
    end
 
    it "should use long format" do
      l(@time, :format => :long).should == "01. grudnia 1985, 16:05"
    end
    
    it "should define am and pm" do
      I18n.backend.translate(Polish.locale, :"time.am").should_not be_nil
      I18n.backend.translate(Polish.locale, :"time.pm").should_not be_nil
    end
  end
 
  protected
    def l(object, options = {})
      I18n.l(object, options.merge( { :locale => Polish.locale }))
    end
end