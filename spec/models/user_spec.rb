require 'pry'

# adding stackprof gen to look at ActiveRecord callgraphs
require 'stackprof'

describe 'User' do
  before do
    @user = User.create(:username => "test 123", :email => "test123@aol.com", :password => "test")
  end
  it 'can slug the username' do
    expect(@user.slug).to eq("test-123")
  end

  it 'can find a user based on the slug' do
    slug = @user.slug
    expect(User.find_by_slug(slug).username).to eq("test 123")
  end

  it 'lets us create a callgraph of the ActiveRecord find method' do
    slug = @user.slug
    # running stackprof around the find_by_slug method
    # to get get a callgraph of all the methods called 
    # under the hood
    data = StackProf.run(mode: :object, interval: 1) do
      User.find_by_slug(slug)
    end

    # dumps graphviz output that can be used to create visualization
    # https://github.com/tmm1/stackprof#stackprofreportnewdataprint_graphviz
    StackProf::Report.new(data).print_graphviz
  end

  it 'has a secure password' do

    expect(@user.authenticate("dog")).to eq(false)

    expect(@user.authenticate("test")).to eq(@user)
  end
end
