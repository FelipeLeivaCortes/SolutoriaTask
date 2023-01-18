<?php

use App\Http\Controllers\IndicatorController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', [IndicatorController::class, 'main'])->name('main');

Route::post('/downloadData', [IndicatorController::class, 'downloadData'])->name('downloadData');

Route::post('/getData', [IndicatorController::class, 'getData'])->name('getData');

Route::resource('data', IndicatorController::class)->names('data');