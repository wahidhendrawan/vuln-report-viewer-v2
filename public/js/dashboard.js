document.addEventListener("DOMContentLoaded", function(){
    fetch('/api/report')
        .then(resp => resp.json())
        .then(data => {
            const ctx = document.getElementById('severityChart').getContext('2d');
            new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: ['Critical','High','Medium','Low','Info'],
                    datasets: [{
                        data: [1,2,3,4,5], // ganti pakai data JSON
                        backgroundColor: ['#c0392b','#e67e22','#f1c40f','#27ae60','#3498db']
                    }]
                }
            });
        });
});
