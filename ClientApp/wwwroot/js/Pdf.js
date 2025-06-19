window.abrirVentanaPDF = async (url) => {
    try {
        const response = await fetch(url, { method: 'HEAD' });

        if (response.ok) {
            window.open(
                url,
                "VisorPDF",
                "width=900,height=700,scrollbars=yes,resizable=yes,toolbar=no,location=no,status=no,menubar=no"
            );
        } else {
            window.open(
                "/no-file.html",
                "ArchivoNoEncontrado",
                "width=600,height=400"
            );
        }
    } catch (e) {
        window.open(
            "/no-file.html",
            "ArchivoNoEncontrado",
            "width=600,height=400"
        );
    }
};
