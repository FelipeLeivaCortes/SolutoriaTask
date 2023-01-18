
const createChart = (data) => {
    let values  = [];
    let labels  = [];

    data.forEach((value) => {
        labels.push(value.date);
        values.push(value.value);
    });

    const title = `Variación de la UF entre ${labels[0]} y ${labels[ labels.length - 1]}`;
    const ctx   = $('#myChart');

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
            label: title,
            data: values,
            borderWidth: 1
            }]
        },
        options: {
            scales: {
            y: {
                beginAtZero: true
            }
            }
        }
    });
}


$(document).ready( function() {
    $('.delete').submit(function(e){
        e.preventDefault();
        Swal.fire({
            title: '¿Estas seguro que desea eliminar este registro?',
            text: "Esta acción es irreversible!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            cancelButtonText: 'Cancelar',
            confirmButtonText: 'Confirmar'
        }).then((result) => {
            if (result.isConfirmed) {
                this.submit();
            }
        })
    });

    $('.myTable').DataTable({
        responsive: true,
        autoWidth: false,
        searching: false,
        language: {
            "url": "//cdn.datatables.net/plug-ins/1.10.16/i18n/Spanish.json"
        },
    });
});

