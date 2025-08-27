<?php

namespace App\Http\Controllers;

use Spatie\LaravelPdf\Facades\Pdf;

class ExportController extends Controller
{
    public function export()
    {
        $path = storage_path('app/report.json');
        $data = file_exists($path) ? json_decode(file_get_contents($path), true) : [];

        return Pdf::view('report_pdf', ['report' => $data])
            ->format('a4')
            ->download('executive-vulnerability-report.pdf');
    }
}
