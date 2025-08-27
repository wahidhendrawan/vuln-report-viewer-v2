<?php

namespace App\Http\Controllers;

class ReportController extends Controller
{
    public function index() { return view('report'); }

    public function data()
    {
        $path = storage_path('app/report.json');
        if (!file_exists($path)) return response()->json(['error' => 'Report not found'], 404);
        return response()->json(json_decode(file_get_contents($path), true));
    }
}
