
module StubGiveawayUserHelper
	def stub_giveaway_user_with(user)
		allow(controller).to receive(:giveaway_user).and_return(user)
	end
end