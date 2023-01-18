<div>
    <div class="form-group">
        {!! Form::label('name', 'Nombre', ['class' => 'form-label']) !!}
        {!! Form::text('name', 'UNIDAD DE FOMENTO (UF)', ['class' => 'form-control', 'required' => 'required']) !!}
    </div>

    <div class="form-group">
        {!! Form::label('unit', 'Unidad', ['class' => 'form-label']) !!}
        {!! Form::text('unit', 'PESOS', ['class' => 'form-control', 'required' => 'required']) !!}
    </div>

    <div class="form-group">
        {!! Form::label('value', 'Valor', ['class' => 'form-label']) !!}
        {!! Form::text('value', null, ['class' => 'form-control', 'required' => 'required']) !!}
    </div>

    <div class="form-group">
        {!! Form::label('date', 'Fecha', ['class' => 'form-label']) !!}
        {!!Form::date('date', \Carbon\Carbon::now(), ['class' => 'form-control', 'required' => 'required']) !!}
    </div>

    <div>
        {!! Form::label('time', 'Tiempo', ['class' => 'form-label']) !!}
        {!!Form::date('time', null, ['class' => 'form-control']) !!}
    </div>

    <div class="form-group">
        {!! Form::label('origin', 'Origen', ['class' => 'form-label']) !!}
        {!! Form::text('origin', null, ['class' => 'form-control', 'required' => 'required']) !!}
    </div>
</div>