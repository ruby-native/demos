class RewardsController < ApplicationController
  def show
    points = current_user.reward_points
    next_reward_at = 500
    render inertia: "Rewards/Show", props: {
      points: points,
      next_reward_at: next_reward_at,
      progress: [points.to_f / next_reward_at * 100, 100].min.round,
      activities: current_user.reward_activities.recent.limit(10).map { |a|
        {id: a.id, description: a.description, points: a.points, created_at: a.created_at.strftime("%b %-d")}
      },
      rewards: [
        {name: "Free drip coffee", points: 150},
        {name: "Free pastry", points: 250},
        {name: "Free any drink", points: 500}
      ]
    }
  end
end
