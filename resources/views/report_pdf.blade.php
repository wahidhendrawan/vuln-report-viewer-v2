<!DOCTYPE html>
<html>
<head>
    <title>PDF Report</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <h1>Executive Vulnerability Report</h1>
    <p>Generated: {{ now() }}</p>

    <h2>Summary</h2>
    <pre>{{ print_r($report['scan_summary'] ?? [], true) }}</pre>

    <h2>Vulnerabilities</h2>
    @foreach($report['vulnerabilities'] ?? [] as $vuln)
        <div>
            <strong>{{ $vuln['severity'] ?? 'Unknown' }}</strong> - {{ $vuln['type'] ?? '' }}
        </div>
    @endforeach
</body>
</html>
