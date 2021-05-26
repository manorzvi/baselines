import gym


class DiffFrame(gym.ObservationWrapper):
    def __init__(self, env):
        super().__init__(env)
        self.noop_action = 0
        assert env.unwrapped.get_action_meanings()[0] == 'NOOP'

    def observation(self, obs):
        self.prev_obs = self.curr_obs
        ret_val = obs - self.curr_obs
        self.curr_obs = obs
        return ret_val

    def reset(self, **kwargs):
        self.prev_obs = self.env.reset(**kwargs)
        self.curr_obs, _, _, _ = self.env.step(self.noop_action)
        ret_val = self.curr_obs - self.prev_obs
        return ret_val
