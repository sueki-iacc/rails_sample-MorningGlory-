# coding: utf-8

0.upto(9) do |idx|
	Article.create({title: "results of battle #{idx}" + (idx%3==0 ? "☆" : ""),
		body: "Morning Gloryが4対2でSunflowerに勝利。\n
		2回表、6番渡辺の二塁打から7番山田、8番高橋の連続タイムリーで2点先生。9回表、ランナー一二塁で2番田中の二塁打で2点を挙げ、ダメを押しました。\n
		投げては初先発の山本が7回を2失点に抑え、伊藤、中村とつないで逃げきりました。",
		released_at: 8.days.ago.advance(days: idx),
		expired_at: 2.days.ago.advance(days: idx),
		member_only: (idx%3==0)
	}, without_protection: true)
end
