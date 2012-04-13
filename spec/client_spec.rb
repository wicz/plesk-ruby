require "spec_helper"
require_relative "../lib/plesk-ruby"

describe Plesk do

  let(:plesk) { Plesk::Client.new("plesk.dev", "user", "pass") }

  let(:mail_name) { 'test_user' }
  let(:mail_password) { '123123' }

  before do
    WebMock.stub_request(:any, /.*conn-refused\.dev.*/).to_raise(Errno::ECONNREFUSED)
    WebMock.stub_request(:any, /.*unknown-host\.dev.*/).to_raise(SocketError)
    WebMock.stub_request(:any, /.*timeout\.dev.*/).to_return { sleep(1) }
    # stub_request(:any, "plesk.com").to_return(:body => "abc", :status => 200,  :headers => { 'Content-Length' => 3 } )
  end

  describe "#add_domain" do
    it "raises exception when connection refused error" do
      plesk.host = "http://conn-refused.dev"
      expect { plesk.add_domain("test.com", "127.0.0.1") }.to raise_error(Plesk::Exception)
    end

    it "raises exception when DNS error" do
      plesk.host = "http://unknown-host.dev"
      expect { plesk.add_domain("test.com", "127.0.0.1") }.to raise_error(Plesk::Exception)
    end

    it "raises exception on timeout" do
      plesk.host = "http://timeout.dev"
      plesk.timeout = 0.1
      expect { plesk.add_domain("test.com", "127.0.0.1") }.to raise_error(Plesk::Exception)
    end

    # it "raises exception on API system error" do
    #   plesk.host = "http://imentore.com.br"
    #   plesk.rpc_version = '1.40.2.0'
    #   expect { plesk.add_domain("test.com", "127.0.0.1") }.to raise_error(Plesk::Exception)
    # end

    # it "raises exception on agent error" do
    #   plesk.host = "imentore.com.br"
    #   plesk.rpc_version = '1.6.0.2'
    #   expect { plesk.add_domain }.to raise_error(Plesk::Exception)
    # end

    # it "raises exception on wrong username" do
    #   plesk.user = "test"
    #   plesk.host = 'imentore.com.br'
    #   response = plesk.add_domain("test.com", "127.0.0.1")
    #   response.success?.should be_false
    #   response.code.should be == "1001"
    # end

    # it "raises exception on wrong password" do
    #   plesk.user = "admin"
    #   plesk.pass = "123"
    #   plesk.host = 'imentore.com.br'
    #   response = plesk.add_domain
    #   response.success?.should be_false
    #   response.code.should be == "1001"
    # end

    # it "raises exception on domain already exist" do
    #   response = plesk.add_domain('imentore.com.br')
    #   response.success?.should be_false
    #   response.code.should be == "1007"
    # end

    # it "can add a domain" do
    #   response = plesk.add_domain(domain_name)
    #   @@plesk_id = response.plesk_id
    #   response.success?.should be_true
    # end

    # it "can add mail account on domain" do
    #   response = plesk.add_mail_domain(@@plesk_id, mail_name, mail_password)
    #   response.success?.should be_true
    # end

    # it "'can change mail account password'" do
    #   response = plesk.change_mail_domain(@@plesk_id, mail_name, "321321")
    #   response.success?.should be_true
    # end

    # it "can remove mail account on domain" do
    #   response = plesk.del_mail_domain(@@plesk_id, mail_name)
    #   response.success?.should be_true
    # end

    # it "can be enable mail domain " do
    #   response = plesk.enable_mail_domain(@@plesk_id)
    #   response.success?.should be_true
    # end

    # it "can be disable mail domain " do
    #   response = plesk.disable_mail_domain(@@plesk_id)
    #   response.success?.should be_true
    # end

    # it "can remove domain" do
    #   response = plesk.del_domain(@@plesk_id)
    #   response.success?.should be_true
    # end
  end
end
