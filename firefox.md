Configuración de Firefox
Firefox en Fedora suele venir bien configurado, pero debemos asegurarnos de que esté forzando el uso de VA-API (Video Acceleration API) sobre Wayland.
    Abre Firefox y escribe about:config en la barra de direcciones. Acepta el riesgo.
Busca y configura los siguientes valores:
    media.ffmpeg.vaapi.enabled -> true
    gfx.webrender.all -> true (Esto fuerza el renderizado por GPU para la interfaz).
Verificación:
    Ve a about:support.
    Busca "Compositing". Debería decir "WebRender".
    Busca "Window Protocol". Debería decir "Wayland" (si usas GNOME/KDE modernos en Fedora).
