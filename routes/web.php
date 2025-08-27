<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ReportController;
use App\Http\Controllers\ExportController;

Route::get('/report', [ReportController::class, 'index']);
Route::get('/api/report', [ReportController::class, 'data']);
Route::get('/report/export/pdf', [ExportController::class, 'export']);
