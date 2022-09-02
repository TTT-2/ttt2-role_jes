L = LANG.GetLanguageTableReference("zh_hans")

-- GENERAL ROLE LANGUAGE STRINGS
L[roles.JESTER.name] = "小丑"
L[roles.JESTER.defaultTeam] = "小丑队伍"
L["hilite_win_" .. roles.JESTER.defaultTeam] = "小丑队伍"
L["win_" .. roles.JESTER.defaultTeam] = "小丑获胜!"
L["info_popup_" .. roles.JESTER.name] = [[你是小丑!制造麻烦,让他们杀了你!]]
L["body_found_" .. roles.JESTER.abbr] = "他们是小丑!"
L["search_role_" .. roles.JESTER.abbr] = "这个人是小丑!"
L["ev_win_" .. roles.JESTER.defaultTeam] = "愚蠢的小丑赢了这一轮!"
L["target_" .. roles.JESTER.name] = "小丑"
L["ttt2_desc_" .. roles.JESTER.name] = [[小丑对于任何叛徒都是可见的,但对于无辜者或其他正常角色(自定义叛徒角色或透视者除外).
小丑不能造成任何伤害或自杀.但如果他死了,他会赢.所以不要杀小丑!]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_jester_info_no_kill"] = "别杀小丑!"
L["ttt2_role_jester_info_no_jester"] = "这一轮没有小丑!"
L["ttt2_role_jester_info_jester_single"] = "'{playername}' 是小丑!"
L["ttt2_role_jester_info_jester_multiple"] = "'{playernames}' 是小丑!"

L["title_event_jester_kill"] = "一个小丑被杀了"
L["desc_event_jester_kill"] = "{jester} 小丑被扳机者杀死了 {killer} ({role} / {team})."
L["tooltip_jester_kill_score_jester"] = "小丑杀人奖励: {score}"
L["jester_kill_score_jester"] = "小丑杀人奖励:"
L["tooltip_jester_kill_score_killer"] = "小丑杀人惩罚: {score}"
L["jester_kill_score_killer"] = "小丑杀人惩罚:"
