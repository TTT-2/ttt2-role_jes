L = LANG.GetLanguageTableReference("ru")

-- GENERAL ROLE LANGUAGE STRINGS
L[JESTER.name] = "Шут"
L[JESTER.defaultTeam] = "Команда шутов"
L["hilite_win_" .. JESTER.defaultTeam] = "ПОБЕДА ШУТОВ"
L["win_" .. JESTER.defaultTeam] = "Шут победил!"
L["info_popup_" .. JESTER.name] = [[Вы шут! Создайте проблемы и позвольте им убить вас!]]
L["body_found_" .. JESTER.abbr] = "Он был шутом!"
L["search_role_" .. JESTER.abbr] = "Этот человек был шутом!"
L["ev_win_" .. JESTER.defaultTeam] = "Глупый шут выиграл раунд!"
L["target_" .. JESTER.name] = "Шут"
L["ttt2_desc_" .. JESTER.name] = [[Шут виден для любого предателя, но не для невинных или других "нормальных" ролей (кроме особых ролей предателя или ясновидящего).
Шут не может нанести урон или убить себя. Но если он умрёт, он ВЫИГРАЕТ. Так что не убивайте шута!]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_jester_killed_by_player"] = "{nick} убил шута!"
L["ttt2_role_jester_killer_info"] = "Вы были убиты, потому что убили шута!"
L["ttt2_role_jester_info_no_kill"] = "Не убивайте шута!"
L["ttt2_role_jester_info_no_jester"] = "В этом раунде нет шута!"
L["ttt2_role_jester_info_jester_single"] = "'{playername}' шут!"
L["ttt2_role_jester_info_jester_multiple"] = "'{playernames}' шуты!"

-- WINSTATE LANGS
L["ttt2_role_jester_winstate_0"] = "Активен случайный выбор выигрыша шута."
L["ttt2_role_jester_winstate_1"] = "Выигрыш шута 1: Вы выиграете, если вас убьют."
L["ttt2_role_jester_winstate_2"] = "Выигрыш шута 2: Вы возродитесь с противоположной ролью вашего убийцы."
L["ttt2_role_jester_winstate_3"] = "Выигрыш шута 3: Вы возродитесь с противоположной ролью вашего убийцы после их смерти."
L["ttt2_role_jester_winstate_4"] = "Выигрыш шута 4: Вы возродитесь с ролью своего убийцы после их смерти."
L["ttt2_role_jester_winstate_5"] = "Выигрыш шута 5: Вы возродитесь с ролью вашего убийцы, и ваш убийца умрёт."
L["ttt2_role_jester_winstate_6"] = "Выигрыш шута 6: Вы возродитесь с противоположной ролью вашего убийцы, и ваш убийца умрёт."
L["ttt2_role_jester_winstate_7"] = "Выигрыш шута 7: Вы возродитесь в роли своего убийцы, и ваш убийца умрёт, если только ваш убийца не серийный убийца или предатель."
