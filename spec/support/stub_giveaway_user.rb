
module StubGiveawayUserHelper
	def stub_giveaway_user_with(user)
		allow(controller).to receive(:giveaways_user).and_return(user)
	end
end