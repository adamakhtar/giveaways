module StubGiveawayHelper
	def stub_giveaway
	  giveaway = build_stubbed(:giveaway)
	  allow(controller).to receive(:load_giveaway).and_return(giveaway)
	  giveaway
	end
end