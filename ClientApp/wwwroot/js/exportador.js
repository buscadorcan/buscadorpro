// exportador.js

window.exportarAPDF = (nombreArchivo, datos) => {
    if (!datos || datos.length === 0) {
        console.warn("⚠️ No hay datos para exportar a PDF.");
        return;
    }

    const doc = new window.jspdf.jsPDF('l', 'pt', 'a4');

    const columnas = Object.keys(datos[0]);
    const filas = datos.map(dato => columnas.map(col => dato[col]));

    doc.text("Resultados Exportados", 40, 40);
    doc.autoTable({
        startY: 60,
        head: [columnas],
        body: filas,
        styles: { fontSize: 8 },
        headStyles: { fillColor: [22, 160, 133] }
    });

    doc.save(`${nombreArchivo}.pdf`);
}
