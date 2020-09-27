L = LANG.GetLanguageTableReference("Русский")

-- GENERAL ROLE LANGUAGE STRINGS
L[JESTER.name] = "Шут"
L[JESTER.defaultTeam] = "Команда Шутов"
L["hilite_win_" .. JESTER.defaultTeam] = "ШУТ ВЫИГРАЛ"
L["win_" .. JESTER.defaultTeam] = "Шут победил!"
L["info_popup_" .. JESTER.name] = [[Вы Шут! Создайте проблемы и позвольте им убить вас!]]
L["body_found_" .. JESTER.abbr] = "Он был Шутом!"
L["search_role_" .. JESTER.abbr] = "Этот человек был Шутом!"
L["ev_win_" .. JESTER.defaultTeam] = "Глупый Шут выиграл раунд!"
L["target_" .. JESTER.name] = "Шут"
L["ttt2_desc_" .. JESTER.name] = [[Шут виден для любого предателя, но не для невинных или других "нормальных" ролей (кроме особых ролей предателя или Ясновидящего).
Шут не может нанести урон или убить себя. Но если он умрёт, он ВЫИГРАЕТ. Так что не убивайте Шута!]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_role_jester_killed_by_player"] = "{nick} убил Шута!"
L["ttt2_role_jester_killer_info"] = "Вы были убиты, потому что убили Шута!"
L["ttt2_role_jester_info_no_kill"] = "Не убивайте Шута!"
L["ttt2_role_jester_info_no_jester"] = "В этом раунде нет Шута!"
L["ttt2_role_jester_info_jester_single"] = "'{playername}' это Шут!"
L["ttt2_role_jester_info_jester_multiple"] = "'{playernames}' это Шуты!"

-- WINSTATE LANGS
L["ttt2_role_jester_winstate_0"] = "Активен случайный выбор выигрыша Шута."
L["ttt2_role_jester_winstate_1"] = "Выигрыш Шута 1: Вы выиграете, если вас убьют."
L["ttt2_role_jester_winstate_2"] = "Выигрыш Шута 2: Вы возродитесь с противоположной ролью вашего убийцы."
L["ttt2_role_jester_winstate_3"] = "Выигрыш Шута 3: Вы возродитесь с противоположной ролью вашего убийцы после их смерти."
L["ttt2_role_jester_winstate_4"] = "Выигрыш Шута 4: Вы возродитесь с ролью своего убийцы после их смерти."
L["ttt2_role_jester_winstate_5"] = "Выигрыш Шута 5: Вы возродитесь с ролью вашего убийцы, и ваш убийца умрёт."
L["ttt2_role_jester_winstate_6"] = "Выигрыш Шута 6: Вы возродитесь с противоположной ролью вашего убийцы, и ваш убийца умрёт."
L["ttt2_role_jester_winstate_7"] = "Выигрыш Шута 7: Вы возродитесь в роли своего убийцы, и ваш убийца умрёт, если только ваш убийца не серийный убийца или Предатель."
