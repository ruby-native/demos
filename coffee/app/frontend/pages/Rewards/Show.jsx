import { Head, Link, usePage } from "@inertiajs/react"
import { NativeNavbar, NativeButton } from "@ruby-native/react"

export default function Show({ points, next_reward_at, progress, activities, rewards, featured_item }) {
  const { nativeApp } = usePage().props

  return (
    <>
      <Head title="Rewards" />
      <NativeNavbar title="Rewards">
        <NativeButton icons={{ ios: "bag", android: "shopping_bag" }} href="/cart" />
      </NativeNavbar>

      <div className="mt-4">
        {!nativeApp && <h1 className="text-2xl font-bold text-coffee-800 dark:text-coffee-100">Rewards</h1>}

        {/* Points balance */}
        <div className="mt-4 p-6 rounded-2xl bg-coffee-800 dark:bg-coffee-200 text-white dark:text-coffee-900 text-center">
          <p className="text-sm font-medium opacity-80">Your balance</p>
          <p className="text-4xl font-bold mt-1">{points}</p>
          <p className="text-sm font-medium opacity-80 mt-1">points</p>
        </div>

        {/* Progress to next reward */}
        <div className="mt-4 p-4 rounded-2xl bg-white dark:bg-coffee-800 shadow-sm">
          <div className="flex items-center justify-between mb-2">
            <span className="text-sm font-medium text-coffee-700 dark:text-coffee-300">Next reward</span>
            <span className="text-sm font-medium text-coffee-500 dark:text-coffee-400">{points}/{next_reward_at}</span>
          </div>
          <div className="w-full h-3 bg-coffee-100 dark:bg-coffee-700 rounded-full overflow-hidden">
            <div className="h-full bg-coffee-800 dark:bg-coffee-200 rounded-full transition-all" style={{ width: `${progress}%` }} />
          </div>
          <p className="text-xs text-coffee-500 dark:text-coffee-400 mt-2">{next_reward_at - points} points until a free drink</p>
          <Link
            href="/menu"
            className="block mt-3 text-sm font-medium text-coffee-800 dark:text-coffee-200 no-underline"
          >
            Browse the menu &rarr;
          </Link>
        </div>

        {/* Featured promo */}
        {featured_item && (
          <Link
            href={featured_item.path}
            className="block mt-4 p-4 rounded-2xl bg-white dark:bg-coffee-800 shadow-sm no-underline"
          >
            <p className="text-xs font-semibold text-green-700 dark:text-green-400 uppercase tracking-wide">Double points this week</p>
            <p className="text-sm font-medium text-coffee-800 dark:text-coffee-100 mt-1">Order a {featured_item.name} and earn 2x rewards &rarr;</p>
          </Link>
        )}

        {/* Available rewards */}
        <div className="mt-6">
          <h2 className="text-sm font-semibold text-coffee-500 dark:text-coffee-400 uppercase tracking-wide">Available rewards</h2>
          <div className="mt-2 space-y-2">
            {rewards.map((reward) => (
              <div key={reward.name} className="flex items-center justify-between p-3 rounded-xl bg-white dark:bg-coffee-800 shadow-sm">
                <span className="text-sm font-medium text-coffee-800 dark:text-coffee-100">{reward.name}</span>
                <span className={`text-xs font-semibold px-2.5 py-1 rounded-full ${
                  points >= reward.points
                    ? "bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-300"
                    : "bg-coffee-100 text-coffee-500 dark:bg-coffee-700 dark:text-coffee-400"
                }`}>
                  {reward.points} pts
                </span>
              </div>
            ))}
          </div>
        </div>

        {/* Recent activity */}
        <div className="mt-6">
          <h2 className="text-sm font-semibold text-coffee-500 dark:text-coffee-400 uppercase tracking-wide">Recent activity</h2>
          <div className="mt-2 space-y-1">
            {activities.map((activity) => (
              <div key={activity.id} className="flex items-center justify-between py-2.5">
                <div>
                  <p className="text-sm font-medium text-coffee-800 dark:text-coffee-100">{activity.description}</p>
                  <p className="text-xs text-coffee-400">{activity.created_at}</p>
                </div>
                <span className={`text-sm font-semibold ${
                  activity.points >= 0 ? "text-green-700 dark:text-green-400" : "text-red-600 dark:text-red-400"
                }`}>
                  {activity.points >= 0 ? `+${activity.points}` : activity.points}
                </span>
              </div>
            ))}
          </div>
        </div>
      </div>
    </>
  )
}
