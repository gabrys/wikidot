
INSERT INTO site VALUES (1, 'My Wiki', 'powered by wikidot software', 'www', '', 'en', NULL, NULL, true, 'start', false, false);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

INSERT INTO admin VALUES(1, 1, 1, true);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

INSERT INTO member VALUES(1, 1, 1, NOW());;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

INSERT INTO category VALUES (1,
    1, '_default',
    true, 20,
    false, 'e:rm;c:rm;m:rm;d:rm;a:rm;r:rm;z:rm;o:rm',
    true, 1, NULL,
    false, 'nav:top', 'nav:side',
    NULL, false, true, NULL, NULL, NULL, true, false, false, NULL
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

INSERT INTO category VALUES (2,
    1, 'auth',
    true, 20,
    false, 'e:;c:;m:;d:;a:;r:;z:;o:',
    true, 1, NULL,
    true, 'nav:top', 'nav:side',
    NULL, false, true, NULL, NULL, NULL, true, false, false, NULL
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

INSERT INTO category VALUES (3,
    1, 'system',
    true, 20,
    false, 'e:;c:;m:;d:;a:;r:;z:;o:',
    true, 1, NULL,
    true, 'nav:top', 'nav:side',
    NULL, NULL, true, NULL, NULL, NULL, true, false, false, NULL
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

INSERT INTO category VALUES (4,
    1, 'search',
    true, 20,
    false, 'e:;c:;m:;d:;a:;r:;z:;o:',
    true, 1, NULL,
    true, 'nav:top', 'nav:side',
    NULL, NULL, true, NULL, NULL, NULL, true, false, false, NULL
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

INSERT INTO category VALUES (5,
    1, 'admin',
    true, 20,
    false, 'e:;c:;m:;d:;a:;r:;z:;o:',
    true, 1, NULL,
    false, 'nav:top', NULL,
    NULL, NULL, true, NULL, NULL, NULL, true, false, false, NULL
);;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

