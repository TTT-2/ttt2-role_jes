L = LANG.GetLanguageTableReference("ru")

-- GENERAL ROLE LANGUAGE STRINGS
L[roles.JESTER.name] = "Шут"
L[roles.JESTER.defaultTeam] = "Команда шутов"
L["hilite_win_" .. roles.JESTER.defaultTeam] = "ПОБЕДА ШУТОВ"
L["win_" .. roles.JESTER.defaultTeam] = "Шут победил!"
L["info_popup_" .. roles.JESTER.name] = [[Вы шут! Создайте проблемы и позвольте им убить вас!]]
L["body_found_" .. roles.JESTER.abbr] = "Он был шутом!"
L["search_role_" .. roles.JESTER.abbr] = "Этот человек был шутом!"
L["ev_win_" .. roles.JESTER.defaultTeam] = "Глупый шут выиграл раунд!"
L["target_" .. roles.JESTER.name] = "Шут"
L["ttt2_desc_" .. roles.JESTER.name] = [[Шут виден для любого предателя, но не для невинных или других "нормальных" ролей (кроме особых ролей предателя или ясновидящего).
Шут не может нанести урон или убить себя. Но если он умрёт, он ВЫИГРАЕТ. Так что не убивайте шута!]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_jester_info_no_kill"] = "Не убивайте шута!"
L["ttt2_role_jester_info_no_jester"] = "В этом раунде нет шута!"
L["ttt2_role_jester_info_jester_single"] = "'{playername}' шут!"
L["ttt2_role_jester_info_jester_multiple"] = "'{playernames}' шуты!"

--L["title_event_jester_kill"] = "A Jester was killed"
--L["desc_event_jester_kill"] = "{jester} the Jester was killed by a triggerhappy {killer} ({role} / {team})."
--L["tooltip_jester_kill_score_jester"] = "Jester kill bonus: {score}"
--L["jester_kill_score_jester"] = "Jester kill bonus:"
--L["tooltip_jester_kill_score_killer"] = "Jester kill penalty: {score}"
--L["jester_kill_score_killer"] = "Jester kill penalty:"
