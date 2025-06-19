window.desmarcarTodosLosCheckboxes = function () {
    document.querySelectorAll("input[type='checkbox']").forEach(cb => cb.checked = false);
};

window.descargarArchivoExcel = (base64, fileName) => {
    const link = document.createElement('a');
    link.href = 'data:application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;base64,' + base64;
    link.download = fileName;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
};
